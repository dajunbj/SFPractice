@isTest
public class A01_Exception_Sample_ControllerTest {

    @isTest static void testTryNullPointerException() {
        try {
            A01_Exception_Sample_Controller.tryNullPointerException();
        } catch (System.DmlException e) {
            system.debug('eeeee:'+e.getDmlMessage(0));
        }
    }

    @isTest static void testTryDmlException() {
        try {
            A01_Exception_Sample_Controller.tryDmlException();
        } catch (System.DmlException e) {
            system.debug('eeeee:'+e.getDmlMessage(0));
        }
    }

    @isTest static void testTryListException() {
        try {
            A01_Exception_Sample_Controller.tryListException();
        } catch (System.DmlException e) {
            system.debug('eeeee:'+e.getDmlMessage(0));
        }
    }
}