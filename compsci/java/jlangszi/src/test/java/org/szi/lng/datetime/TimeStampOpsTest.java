package org.szi.lng.datetime;

import org.junit.*;

import java.time.Duration;
import java.time.Instant;
import java.util.concurrent.TimeUnit;

public class TimeStampOpsTest {

    final int timeoutSeconds = 5;

    @Test
    public void testTimeout(){
        try{
            Instant start  =Instant.now();
            Instant current;
            do{
                TimeUnit.SECONDS.sleep(1);
                current = Instant.now();
                System.out.println("slept incremental second");
            }while(Duration.between(start,current).getSeconds() < timeoutSeconds);
            System.out.println("timed-out");
        }catch  (InterruptedException e) {
        throw new IllegalStateException("task interrupted", e);
        }
    }
}

