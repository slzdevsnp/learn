package org.szi.lng.file;

import de.siegmar.fastcsv.writer.CsvAppender;
import de.siegmar.fastcsv.writer.CsvWriter;

import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardOpenOption;
import java.text.SimpleDateFormat;
import java.time.Instant;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;


class MyCsvWriter  {
    private CsvWriter csvwriter;
    private File file;
    private CsvAppender appender;
    public MyCsvWriter(CsvWriter csvwriter, File file){
        this.csvwriter = csvwriter;
        this.file = file;
    }

    protected void setAppender(){
        try {
            this.appender = this.csvwriter.append(this.file, StandardCharsets.UTF_8);
        }catch(IOException e){
            e.printStackTrace();
        }
    }

    protected void writeHeader(){
        try{
            this.appender.appendLine("timestamp","symbol","bid_price","ask_price");
        }catch(IOException e){
            e.printStackTrace();
        }
    }

    protected void appendDataLine(String symbol, double bidpx, double askpx){
        String tstamp = new SimpleDateFormat("yyyy.MM.dd HH.mm.ss.SSS").format(new Date());

        try {
            this.appender.appendLine(tstamp,symbol,String.valueOf(bidpx),String.valueOf(askpx));
        }catch(IOException e){
            e.printStackTrace();
        }
    }

}

class myNioCsvWriter {
    private String filename;
    private Character delim = ',';

    public myNioCsvWriter(String filename){
        this.filename = filename;
    }

    protected void writeHeader(){
        File file = new File(this.filename);
        if (file.exists()){
            file.delete();
        }
        String headerLine = "timestamp"+this.delim+"symbol"+this.delim
                +"bid_price"+this.delim+"ask_price"+"\r\n";
        try {
            file.createNewFile();
            Files.write(Paths.get(this.filename),headerLine.getBytes(), StandardOpenOption.APPEND);
        }catch(IOException e){
            e.printStackTrace();
        }
    }

    protected void appendDataLine(String symbol, double bidpx, double askpx){
        //String tstamp = new SimpleDateFormat("yyyy.MM.dd HH.mm.ss.SSS").format(new Date());
        Instant ltstamp = Instant.now();

        String dataLine = String.format("%s,%s,%f,%f",ltstamp,symbol,bidpx,askpx)+"\r\n";
        try {
            Files.write(Paths.get(this.filename),dataLine.getBytes(), StandardOpenOption.APPEND);
        }catch(IOException e){
            e.printStackTrace();
        }

    }
}


public class FastCsvWriterRunner {

    static final String csvFn = "/tmp/quotes.csv";


    static void testMyAppending(){
        File csvFile = new File(csvFn);
        CsvWriter csvWriter = new CsvWriter();
        MyCsvWriter mywriter = new MyCsvWriter(csvWriter,csvFile);
        mywriter.setAppender();
        mywriter.writeHeader();
        mywriter.appendDataLine("EUR/USD", 1.12065,1.12084);
        mywriter.appendDataLine("EUR/USD", 1.12067,1.12088);
    }

    static void testMyNioAppending(){
        myNioCsvWriter mywriter = new myNioCsvWriter("/tmp/quotes.csv");
        mywriter.writeHeader();
        int i = 0;
        do {
            mywriter.appendDataLine("EUR/USD", 1.12065, 1.12084);
            i++;
        }while ( i < 100);
    }

    static void refTestAppendA(){
        File file = new File("/tmp/foo.csv");
        CsvWriter csvWriter = new CsvWriter();

        try (CsvAppender csvAppender = csvWriter.append(file, StandardCharsets.UTF_8)) {
            // header
            csvAppender.appendLine("header1", "header2");

            // 1st line in one operation
            csvAppender.appendLine("value1", "value2");

            // 2nd line in split operations
            csvAppender.appendField("value3");
            csvAppender.appendField("value4");
            csvAppender.endLine();

        }catch(IOException e){
            e.printStackTrace();
        }
    }
    static void refTestAppendB(){
        File file = new File("/tmp/foo.csv");
        CsvWriter csvWriter = new CsvWriter();

        try (CsvAppender csvAppender = csvWriter.append(file, StandardCharsets.UTF_8)) {
            csvAppender.appendLine("value6", "value7");
            csvAppender.appendLine("value8", "value9");
            csvAppender.endLine();
        }catch(IOException e){
            e.printStackTrace();
        }
    }


    public static void main(String[] args) {
        //testMyAppending();
        //refTestAppendA();
        //refTestAppendB();

        //ZonedDateTime now = ZonedDateTime.now(ZoneId.of("UTC"));
        Instant now  =Instant.now();
        System.out.println("Instant to String" + now.toString());
        System.out.println("now Instant iso formatted:" +
                DateTimeFormatter.ISO_INSTANT.format(Instant.now()));

        testMyNioAppending();
    }
}
