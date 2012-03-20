package com.kaltura.edw.components.fltr.cat
{
	/**
	 * this class lists possible values for <code>CatTree.mode</code> attribute 
	 * @author Atar
	 */
	public class CatTreeSelectionMode {
		
		/**
		 * single selection mode.
		 * the tree will only allow selection of a single item 
		 */
		public static const SINGLE_SELECT:int = 1;
		
		
		/**
		 * multiple selection mode.
		 * when selecting items, only the items selected by the user will be selected
		 */
		public static const MULTIPLE_SELECT_EXACT:int = 2;
		
		
		/**
		 * multiple selection with children mode.
		 * when selecting items, all the items under the user's selection will be selected
		 */
		public static const MULTIPLE_SELECT_PLUS:int = 3;
		
	}
}