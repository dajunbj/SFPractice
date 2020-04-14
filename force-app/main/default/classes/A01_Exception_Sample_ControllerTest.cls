@isTest
public class A01_Exception_Sample_ControllerTest {

    @isTest static void testTryNullPointerException() {

        A01_Exception_Sample_Controller.tryNullPointerException();
    }

    @isTest static void testTryDmlException() {
        A01_Exception_Sample_Controller.tryDmlException();
    }

    @isTest static void testTryListException() {
        A01_Exception_Sample_Controller.tryListException();
    }
}