package org.szi.lng.datetime;

import org.junit.*;
import org.assertj.core.api.Assertions;

import java.time.*;
import java.util.concurrent.TimeUnit;

public class TimeStampOpsTest {

    final int timeoutSeconds = 2;

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
        Assertions.assertThat(true);
    }

    @Test
    public void testInstants(){
        Instant now = Instant.now();
        System.out.println("instant:"+now);
        String strts = now.toString();
        String[] parts = strts.split("\\.");
        String microseconds = parts[1].substring(0,6);
        System.out.println("ms:"+microseconds);
        String fn = parts[0]+"S"+microseconds;
        System.out.println("fn:"+fn);


        Assertions.assertThat(true);
    }

    @Test
    public void testMkCurrentFileName(){
        LocalDateTime dt = LocalDateTime.of(2019, Month.MAY, 1, 16, 24, 56, 333666777);
        Instant instant = dt.atZone(ZoneId.of("UTC")).toInstant();
        String fn = initiateCurrentFileName(instant);
        Assertions.assertThat(fn).isEqualTo("2019-05-01T16:24:56MS333666_.csv");
    }

    private String instantToFn(Instant ts){
        String strts = ts.toString();
        String[] parts = strts.split("\\.");
        String microseconds = parts[1].substring(0,6);
        return parts[0]+"MS"+microseconds;
    }
    private String initiateCurrentFileName(Instant ts){
        return instantToFn(ts)+"_.csv";
    }
    private String completeCurrentFileName(String fn, Instant ts){
        String[] parts = fn.split("\\.");
        return parts[0] + instantToFn(ts)+"."+parts[1];
    }

    @Test
    public void testCompleteCurrentFileName(){
        LocalDateTime dt = LocalDateTime.of(2019, Month.MAY, 1, 16, 24, 56, 333666777);
        Instant instant1 = dt.atZone(ZoneId.of("UTC")).toInstant();
        String fn = initiateCurrentFileName(instant1);

        dt = LocalDateTime.of(2019, Month.MAY, 1, 16, 59, 59, 333555777);
        Instant instant2 = dt.atZone(ZoneId.of("UTC")).toInstant();
        fn = completeCurrentFileName(fn, instant2);
        Assertions.assertThat(fn).isEqualTo("2019-05-01T16:24:56MS333666_2019-05-01T16:59:59MS333555.csv");
    }

}

