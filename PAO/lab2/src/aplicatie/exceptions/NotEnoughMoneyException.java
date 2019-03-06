package aplicatie.aplicatie.exceptions;

public class NotEnoughMoneyException extends RuntimeException {

    public NotEnoughMoneyException() {
        super("There is not enough money in the account!");
    }
}
