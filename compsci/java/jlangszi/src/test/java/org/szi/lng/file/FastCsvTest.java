package org.szi.lng.file;


import de.siegmar.fastcsv.writer.CsvAppender;
import de.siegmar.fastcsv.writer.CsvWriter;
import org.assertj.core.api.Assertions;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.junit.After;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;

import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;

public class FastCsvTest {

    private static final String csvFn = "src/main/resources/quotes.csv";
    private static File csvfile;
    private static CsvWriter csvWriter = new CsvWriter();

    @BeforeClass
    public static void setUp() throws IOException {
        csvfile = new File(csvFn);
        if (csvfile.exists()){
            csvfile.delete();
        }
        csvfile.createNewFile();
    }


    @Test
    public void testApendCsvHeader() throws IOException{
        try (CsvAppender csvAppender =
                     csvWriter.append(csvfile, StandardCharsets.US_ASCII)){
            csvAppender.appendLine("timestamp","symbol","bid_price","ask_price");
        }
        Assertions.assertThat(csvfile.length() >0);
    }

    @Test
    public void testAppendDataLine() throws IOException{
        String symb = "EUR/USD";
        String tstamp = new SimpleDateFormat("yyyy.MM.dd HH.mm.ss.SSS").format(new Date());
        double bidPrice = 1.130564;
        double askPrice = 1.130784;
        try (CsvAppender csvAppender =
                     csvWriter.append(csvfile, StandardCharsets.US_ASCII)){
            csvAppender.appendLine(tstamp,symb,String.valueOf(bidPrice),String.valueOf(askPrice));

        }
        Assertions.assertThat(csvfile.length() >0);
    }

}
