import schimb_valutar.Date;
import schimb_valutar.Services;
import schimb_valutar.Valuta;

import java.time.LocalDate;

public class Main {
    public static void main(String[] args) {
        Services x = new Services();
        Valuta v = new Valuta("Euro", "EUR", 4.7, 0.02, 0.03);
        Valuta v2 = new Valuta("Dollar", "USD", 4.1, 0.02, 0.03);
        x.adaugaValuta(v);
        x.adaugaValuta(v2);
        try {
            Valuta v3 = x.getInfoValutaActual("USD");
            System.out.println(v3.getCurs());
            Valuta v4 = x.getInfoValutaActual("RON");
            System.out.println(v4.getNume());
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        Valuta v4 = new Valuta("Dollar", "USD", 4.4, 0.02, 0.03);
        try {
            x.updateValutaActual(v4);
            System.out.println(x.getInfoValutaActual("USD").getCurs());
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        System.out.println("Istoric: ");
        x.printIstoric();
        x.addCasier("Iuga", "Stefan");
        x.addCasier("Popescu", "Ionescu");
        x.addClient("Gigi", "Gigel", 123456789123L, "RK", 1234);
        x.addClient("Gigica", "Gigelica", 911923841234L, "RD", 1221);
        x.printCasieri();
        x.printClienti();
        LocalDate date = LocalDate.now();
        Date mydate = new Date(date.getDayOfMonth(), date.getMonthValue(), date.getYear());
        try {
            x.getValutaLaData(mydate, "USD");
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }
}
