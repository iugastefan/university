package schimb_valutar;

import java.time.LocalDate;
import java.util.*;

final public class Services {
    // TODO: de facut o clasa Date personala
    private Map<Date, List<Valuta>> istoric;
    private List<Valuta> actual;

    public Services() {
        // TODO: de facut baza de date
        istoric = new TreeMap<>(Collections.reverseOrder());
        actual = new ArrayList<>();
        LocalDate date = LocalDate.now();
        Date mydate = new Date(date.getDayOfMonth(), date.getMonthValue(), date.getYear());
        istoric.put(mydate, actual);
    }

    public void adaugaValuta(Valuta v) {
        actual.add(v);
    }

    public Valuta getInfoValutaActual(String v) throws Exception {
        for (Valuta x : actual) {
            if (x.getNume().equals(v) || x.getPrescurtare().equals(v))
                return x;
        }
        throw new Exception("Valuta " + v + " nu exista");
    }

    public void updateValutaActual(Valuta v) throws Exception {
        int index = 0;
        for (Valuta x : actual) if (!x.getNume().equals(v.getNume())) index++;
        if (index >= actual.size())
            throw new Exception("Valuta " + v.getNume() + " nu exista");
        actual.set(index, v);
    }

    public Valuta getValutaLaData(Date date, String nume) throws Exception {
        List<Valuta> lista = istoric.get(date);
        if (lista == null)
            throw new Exception("Data " + date + " nu exista in istoric");
        for (Valuta x : lista) {
            if (x.getNume().equals(nume) || x.getPrescurtare().equals(nume))
                return x;
        }
        throw new Exception("Valuta" + nume + " nu exista la data " + date);
    }
}
