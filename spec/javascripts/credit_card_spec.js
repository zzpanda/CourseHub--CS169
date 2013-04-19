/**
 * Created with JetBrains RubyMine.
 * User: cgioia
 * Date: 4/18/13
 * Time: 6:34 PM
 * To change this template use File | Settings | File Templates.
 */
describe("CreditCard", function() {
    it("cleans number by removing spaces", function() {
        expect(CreditCard.cleanNumber("12 3 4 5")).toEqual("12345");
    });
});