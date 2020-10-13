package cloud.nativ.serverless;

import static org.junit.jupiter.api.Assertions.assertNotNull;

import java.util.Map;

import org.junit.jupiter.api.Test;

import io.quarkus.amazon.lambda.test.LambdaClient;
import io.quarkus.test.junit.QuarkusTest;

@QuarkusTest
class LambdaHandlerTest {

    @Test
    void testSimpleLambdaSuccess() throws Exception {
        Map<String, Object> response = LambdaClient.invoke(Map.class, null);
        assertNotNull(response);
    }

}
