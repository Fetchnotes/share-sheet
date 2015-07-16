package io.trigger.forge.android.modules.share_sheet;

import io.trigger.forge.android.core.ForgeApp;
import io.trigger.forge.android.core.ForgeParam;
import io.trigger.forge.android.core.ForgeTask;
import android.content.Intent;

public class API {

	private static final String FOOTER = "\n\nvia Fetchnotes (http://fetchnotes.com/)";

	/**
	 * @param task Forge.IO task object, used to return data and trigger
	 * @param text Text content of the note
	 * @param url First URL in the note, if any
	 * @param archived 'true' if the note has been archived, or 'false'
	 * @param publicLink URL to view the note on Fetchnotes' web app
	 */
	public static void show(final ForgeTask task,
			@ForgeParam("text") final String text,
			//@ForgeParam("url") final String url,
			@ForgeParam("archived") final String archived,
			@ForgeParam("publicLink") final String publicLink){

		Intent share = new Intent(android.content.Intent.ACTION_SEND);
		share.setType("text/plain");
		share.addFlags(Intent.FLAG_ACTIVITY_CLEAR_WHEN_TASK_RESET);

		String body = text + "\n\n" + publicLink + FOOTER;

		share.putExtra(Intent.EXTRA_SUBJECT, "Thought you might be interested in this");
		share.putExtra(Intent.EXTRA_TEXT, body);

		ForgeApp.getActivity().startActivity(Intent.createChooser(share, "Share your note"));
		
		task.success();
	}
}
