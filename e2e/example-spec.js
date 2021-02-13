// spec.js
describe('Protractor Demo App', function() {
  it('should have a title', function() {
    browser.waitForAngularEnabled(false);
    browser.ignoreSynchronization = true;
    browser.get('http://localhost:4200/');

    expect(browser.getTitle()).toEqual('SB Admin Angular9 BS5');
  });
})
