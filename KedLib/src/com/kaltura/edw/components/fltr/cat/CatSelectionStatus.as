package com.kaltura.edw.components.fltr.cat
{
	/**
	 * optional values for CategoryVO.selected attribute 
	 * @author Atar
	 * 
	 */	
	public class CatSelectionStatus {
		
		/**
		 * the category is not selected.
		 * in partial selection mode: none of the category's children are selected 
		 */
		public static const UNSELECTED:int = 0;
		
		
		/**
		 * in partial selected mode only: some of the categories 
		 */
		public static const PARTIAL:int = 1;
		
		
		/**
		 * the category is selected.
		 * in partial selection mode: all the category's children are selected
		 */
		public static const SELECTED:int = 2;
	}
}