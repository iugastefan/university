package schimb_valutar;

import java.util.*;

public class Services {
    // TODO: de facut o clasa Date personala
    private Map<Date, List<Valuta>> istoric;
    private List<Valuta> actual;

    public Services() {
        // TODO: de facut baza de date
        istoric = new TreeMap<>();
        actual = new ArrayList<>();
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
}
