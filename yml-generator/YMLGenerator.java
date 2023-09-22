import java.io.FileWriter;
import java.io.IOException;

public class YMLGenerator {

    public static void main(String[] args) {
        int numberOfPeers = 8; //Number of Peers

        try (FileWriter writer = new FileWriter("containerlab-topology.yml")) {
            writer.write("name: containerlab-topology\n");
            writer.write("prefix: p2p\n");
            writer.write("topology:\n");
            writer.write("  nodes:\n");

            // Creating of sender
            writer.write("    sender:\n");
            writer.write("      kind: linux\n");
            writer.write("      image: p2p-topology\n");

            // Creating peers
            for (int i = 1; i <= numberOfPeers; i++) {
                writer.write("    peer" + i + ":\n");
                writer.write("      kind: linux\n");
                writer.write("      image: p2p-topology\n");
            }

            writer.write("\n  links:\n");

            // Connection between sender and peers
            for (int i = 1; i <= numberOfPeers; i++) {
                writer.write("    - endpoints: [\"sender:eth" + i + "\", \"peer" + i + ":eth1\"]\n");
            }

        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
