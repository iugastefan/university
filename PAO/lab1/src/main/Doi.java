package main;

import java.util.Scanner;

class Doi {
    static void ceva() {
        Scanner s = new Scanner(System.in);
        int x = s.nextInt();
        if (x % 2 == 0)
            System.out.println("Par");
        else
            System.out.println("Impar");
    }

}
