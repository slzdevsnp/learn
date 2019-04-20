package org.szi;


import static org.assertj.core.api.Assertions.*;
import org.junit.jupiter.api.*;

import java.util.ArrayList;
import java.util.List;


public class JUnit5WSetupTest {

    private List<String> mylist;
    static int mylength;
    @BeforeAll
    static void beforeAll(){    //must be declared static, runs before all tests
        mylength = 3;
        System.out.println("before all tests methods");
    }

    @BeforeEach
    void beforeEach(){
        System.out.println("before each test method");
        mylist = new ArrayList<String>();
    }
    @AfterEach
     void afterEach(){
        System.out.println("after each test method");
    }

    @AfterAll
    static void afterAll(){    //must be declared static, runs before all tests
        mylength = 0;
        System.out.println("after all tests methods");
    }


    @Test
    void testPopulateList(){
        System.out.println("testPopulateList()");
        mylist.add("a");
        mylist.add("b");
        mylist.add("c");
        mylist.add("e");
        for (int i = 0; i<mylength;i++){
            System.out.println(" 3 first list elems:" + mylist.get(i));
        }
        assertThat(mylist.size()).isGreaterThan(3);
    }

    @Test
    void dummyTest(){
        System.out.println("dummyTest()");
        assertThat(mylist.size()).isEqualTo(0);
    }

}
