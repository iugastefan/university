package main;

import java.util.Scanner;

public class Patru {
    static void prim(){
        Scanner x = new Scanner(System.in);
        int v =x.nextInt();
        for(int a=2;a<v/2;a++)
        {
            if(v%a==0)
            {
                System.out.println("Nu e prim");
                return;
            }
        }
        System.out.println("Prim");
    }
}
