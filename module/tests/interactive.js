module("share_sheet");

// In this test we call the example showAlert API method with an example string
asyncTest("Share a link", 1, function() {
	forge.internal.call('share_sheet.show', {
		text: "Check out this awesome note I wrote!",
		url: void 0,
		archived: 'false',
		publicLink: "http://fetchnotes.com/test-url"
	}, function () {
		askQuestion("Were you prompted to share a message?", {
			Yes: function () {
				ok(true, "User claims success");
				start();
			},
			No: function () {
				ok(false, "User claims failure");
				start();
			}
		});
	}, function () {
		ok(false, "API method returned failure");
		start();
	});
});
