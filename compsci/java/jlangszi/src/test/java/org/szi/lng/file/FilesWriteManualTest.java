package org.szi.lng.file;

import com.baeldung.util.StreamUtils;
import org.assertj.core.api.Assertions;


import java.io.File;
import java.io.FileInputStream;
import java.io.PrintWriter;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardOpenOption;

import org.junit.Test;
import org.junit.Before;
import org.junit.After;
import org.junit.Assert;


public class FilesWriteManualTest {


    private static final String fileName = "src/main/resources/countries.properties";

    @Before
    public void tearUp() throws  IOException{
    }



    @After
    public void tearDown() throws IOException{

        PrintWriter writer = new PrintWriter(fileName);
        writer.print("UK\r\n" + "US\r\n" + "Germany\r\n");
        writer.close();
    }


    @Test
    public void whenAppendToFileUsingFiles() throws IOException {

        String field = "Spain";
        String fieldlr = field+"\r\n";
        Files.write(Paths.get(fileName), fieldlr.getBytes(), StandardOpenOption.APPEND);

        Assertions.assertThat(StreamUtils.getStringFromInputStream(new FileInputStream(fileName))).isEqualTo("UK\r\n" + "US\r\n" + "Germany\r\n" + "Spain\r\n");
    }




}
