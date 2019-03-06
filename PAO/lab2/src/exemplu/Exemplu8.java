import java.util.Arrays;
import java.util.Comparator;

public class Exemplu8 {
    public static void main(String[] args) {

        Cat[] c = new Cat[4];
        c[0] = new Cat("Tom", 3);
        c[1] = new Cat("Leo", 1);
        c[2] = new Cat("Mitty", 2);
        c[3] = new Cat("Kitty", 4);
        for (Cat cat :
                c) {
            System.out.println(cat);
        }
        Arrays.sort(c, Comparator.comparingInt(Cat::getAge));
        for (Cat cat :
                c) {
            System.out.println(cat);
        }
    }
}
