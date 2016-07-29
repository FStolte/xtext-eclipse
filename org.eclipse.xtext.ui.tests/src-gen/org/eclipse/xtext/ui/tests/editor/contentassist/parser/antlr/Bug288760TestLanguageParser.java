/*
 * generated by Xtext
 */
package org.eclipse.xtext.ui.tests.editor.contentassist.parser.antlr;

import com.google.inject.Inject;
import org.eclipse.xtext.parser.antlr.AbstractAntlrParser;
import org.eclipse.xtext.parser.antlr.XtextTokenStream;
import org.eclipse.xtext.ui.tests.editor.contentassist.parser.antlr.internal.InternalBug288760TestLanguageParser;
import org.eclipse.xtext.ui.tests.editor.contentassist.services.Bug288760TestLanguageGrammarAccess;

public class Bug288760TestLanguageParser extends AbstractAntlrParser {

	@Inject
	private Bug288760TestLanguageGrammarAccess grammarAccess;

	@Override
	protected void setInitialHiddenTokens(XtextTokenStream tokenStream) {
		tokenStream.setInitialHiddenTokens("RULE_WS", "RULE_ML_COMMENT");
	}
	

	@Override
	protected InternalBug288760TestLanguageParser createParser(XtextTokenStream stream) {
		return new InternalBug288760TestLanguageParser(stream, getGrammarAccess());
	}

	@Override 
	protected String getDefaultRuleName() {
		return "WorkflowElement";
	}

	public Bug288760TestLanguageGrammarAccess getGrammarAccess() {
		return this.grammarAccess;
	}

	public void setGrammarAccess(Bug288760TestLanguageGrammarAccess grammarAccess) {
		this.grammarAccess = grammarAccess;
	}
}