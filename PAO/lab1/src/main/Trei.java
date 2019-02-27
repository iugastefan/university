package main;

import java.util.Scanner;

class Trei {
    static void trei() {
        Scanner x = new Scanner(System.in);
        int v = x.nextInt();
        int fact = 1;
        while (v != 1)
            fact *= v--;
        System.out.println(fact);

    }
}
