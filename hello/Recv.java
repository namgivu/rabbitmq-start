import com.rabbitmq.client.*;
import java.io.IOException;

public class Recv {

    private final static String QUEUE_NAME = "hello";

    public static void main(String[] argv) throws Exception {
        //create client
        ConnectionFactory factory = new ConnectionFactory();
        factory.setHost("localhost");
        Connection connection = factory.newConnection();
        Channel channel = connection.createChannel();

        //select queue
        channel.queueDeclare(QUEUE_NAME, false, false, false, null);

        //start listening
        Consumer consumer = new DefaultConsumer(channel) {
            @Override
            public void handleDelivery(String consumerTag, Envelope envelope, AMQP.BasicProperties properties, byte[] body) throws IOException {
                String message = new String(body, "UTF-8");
                System.out.println(" [x] Received '" + message + "'");
            }
        };
        System.out.println(" [*] Waiting for messages. To exit press CTRL+C"); //TODO put this 1-line below
        channel.basicConsume(QUEUE_NAME, true, consumer);
    }

}
