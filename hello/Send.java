import com.rabbitmq.client.Channel;
import com.rabbitmq.client.Connection;
import com.rabbitmq.client.ConnectionFactory;

public class Send {

    private final static String QUEUE_NAME = "hello";

    public static void main(String[] argv) throws Exception {
        //create client
        ConnectionFactory factory = new ConnectionFactory();
        factory.setHost("localhost");
        Connection connection = factory.newConnection();
        Channel channel = connection.createChannel();

        //select queue
        channel.queueDeclare(QUEUE_NAME, false, false, false, null);

        //send message
        String message = "Hello World!";
        channel.basicPublish("", QUEUE_NAME, null, message.getBytes("UTF-8"));
        System.out.println(" [x] Sent '" + message + "'");

        //close client
        channel.close();
        connection.close();
    }

}