package game.of.life.validation;

import org.eclipse.xtext.validation.Check 
//import game.of.life.dSL.Game;
import game.of.life.dSL.Rule;

 
class DSLValidator extends AbstractDSLValidator {
	@Check
	def checkLiveRules(Rule rule) {
		if (rule.op == '<') {
			{warning("Useless Rule : exists with `<0` ",null)}
		}
	}
}