import java.math.BigDecimal;
import java.util.Arrays;
import java.util.List;
import java.util.OptionalDouble;
import java.util.function.Predicate;
import java.util.stream.Stream;

import static oracle.jrockit.jfr.events.Bits.doubleValue;

class PickShareFunctional {

    public static final List<String> symbols
            = Arrays.asList("IBM", "AAPL", "AMZN", "CSCO", "SNE", "GOOG", "MSFT", "ORCL", "FB", "VRSN");

    public static void findHighPriced(Stream<String> shares) {
        System.out.println("High priced under $500 is "+shares.map(
                s -> ShareUtil.getPrice(s)
        ).filter(
                i -> ShareUtil.isPriceLessThan(500).test(i)
        ).reduce(
                (shareInfo, shareInfo2) -> ShareUtil.pickHigh(shareInfo, shareInfo2)
        ));
    }

    public static void PickShareImperative(){
        ShareInfo highPriced = new ShareInfo("", BigDecimal.ZERO);
        final Predicate isPriceLessThan500 = ShareUtil.isPriceLessThan(500); for(
                String symbol :Shares.symbols)

        {
            ShareInfo shareInfo = ShareUtil.getPrice(symbol);
            if (isPriceLessThan500.test(shareInfo)) highPriced = ShareUtil.pickHigh(highPriced, shareInfo);
        } System.out.println("High priced under $500 is "+highPriced);

    }

    public static void main(String args[]){

        PickShareImperative();
        findHighPriced(symbols.stream());
    }
}