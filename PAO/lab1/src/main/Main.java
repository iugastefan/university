package main;

public class Main {
    public static void main(String[] args) {
        System.out.println("Bau bau!");
        char c = 'a';
        c += 1;
        int x = 0547;
        int y = 0xff;
        int w = 0b111011;
        System.out.println(c);
        System.out.println(x);
        System.out.println(y);
        System.out.println(w);
        float f = 10.5f;
        int a = 3 < 5 ? 4 < 5 ? 5 : 4 : 4;
        System.out.println(a);
//        Unu.arata('w');
//        Doi.ceva();
//        Trei.trei();
//        Patru.prim();
        Pisica ea = new Pisica("Ea","rosu");
        ea.Afis();
        Pisica el = new Pisica();
        el.Afis();
    }

}
