package game.of.life.validation;

import org.eclipse.xtext.validation.Check 

import game.of.life.dSL.Pattern;

import game.of.life.dSL.Grid;
import game.of.life.dSL.Mark;

import game.of.life.dSL.Rules;
import game.of.life.dSL.Rule;

 
class DSLValidator extends AbstractDSLValidator {
	@Check def UselessRule(Rule rule) {
		if (rule.op == '<' && rule.NCount == 0) {
			{warning("Useless Rule : exists with `<0` ",null)}
		}
	}
	
	@Check def MarksInGrid(Grid grid) {
		for (Mark m: grid.marks) {
			if (m.poi !== null) {
				if (m.poi.x > grid.size.x || m.poi.y > grid.size.y) {
					{error("Point defined outside of grid", null)}
				}
			} else {
				if (m.pat.loc.x > grid.size.x || m.pat.loc.x > grid.size.x) {
					{error("Pattern defined outside of grid", null)}
				}
			}
		}
	}
	
	@Check def GridSizeOver4k(Grid grid) {
		if (grid.size.x >= 384 || grid.size.y >= 216) {
			{error("Defined grid does not fit on a (4k) screen", null)}
		}
	}
	
	@Check def GridSizeOver2k(Grid grid) {
		if (grid.size.x > 240 || grid.size.y > 120) {
			{warning("Defined grid does not fit on a (2k) screen", null)}
		}
	}
	
	@Check def GridSizeMinimal(Grid grid) {
		if (grid.size.x < 40 || grid.size.y < 40) {
			{warning("Grid size smaller than minimal window size, so that is taken instead", null)}
		}
	}	
	
	@Check def PatternHasLocation(Pattern pattern) {
		if (pattern.loc === null) {
			{error("Pattern has no location", null)}
		}
	}
	
	@Check def RulesExist(Rules rules) {
		if (rules.rules.size() == 0) {
			{warning("Anarchy: Game has no rules, so everyone and everything will die", null)}
		}
	}
}
