// Expose the native API to javascript
forge.share_sheet = {
    show: function (params, success, error) {
        forge.internal.call('share_sheet.show', {
        	text: text,
        	url: url,
            archived: archived,
        	publicLink: publicLink
        }, success, error);
    }
};