package org.szi;

import java.util.stream.Stream;

public class Dummy {

    public static boolean isOdd(int number) {
        return number % 2 != 0;
    }

    public static boolean isBlank(String input) {
        return input == null || input.trim().isEmpty();
    }

    static Stream<String> blankStrings() {
        return Stream.of(null, "", "  ");
    }

}
