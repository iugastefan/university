package schimb_valutar;

import java.time.LocalDate;
import java.util.*;

final public class Services {
    // TODO: de facut o clasa Date personala
    private Map<Date, List<Valuta>> istoric;
    private List<Valuta> actual;
    private List<Casier> casieri;
    private List<Client> clienti;

    public Services() {
        // TODO: de facut baza de date
        istoric = new TreeMap<>(Collections.reverseOrder());
        actual = new ArrayList<>();
        LocalDate date = LocalDate.now();
        Date mydate = new Date(date.getDayOfMonth(), date.getMonthValue(), date.getYear());
        istoric.put(mydate, actual);
        casieri = new ArrayList<>();
        clienti = new ArrayList<>();
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

    public void getValutaLaData(Date date, String nume) throws Exception {
        List<Valuta> lista = istoric.get(date);
        if (lista == null)
            throw new Exception("Data " + date + " nu exista in istoric");
        for (Valuta x : lista) {
            if (x.getNume().equals(nume) || x.getPrescurtare().equals(nume))
                System.out.println(x);
        }
        throw new Exception("Valuta" + nume + " nu exista la data " + date);
    }

    public void printIstoric() {
        Iterator it = istoric.entrySet().iterator();
        while (it.hasNext()) {
            Map.Entry x = (Map.Entry) it.next();
            System.out.println(x.getKey() + ": ");
            for (Valuta y : (List<Valuta>) x.getValue()) {
                System.out.println("\t" + y.getNume() + " " + y.getCurs());
            }
            it.remove();
        }
    }

    public void addClient(String nume, String prenume, long cnp, String serie_id, int numar_id) {
        Client x = new Client(nume, prenume, cnp, serie_id, numar_id);
        clienti.add(x);
    }

    public void addCasier(String nume, String prenume) {
        Casier x = new Casier(nume, prenume);
        casieri.add(x);
    }

    public void printClienti() {
        clienti.forEach(System.out::println);
    }

    public void printCasieri() {
        casieri.forEach(System.out::println);
    }

}
