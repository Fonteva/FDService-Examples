/*
 * -----------------------------------------------------------------------------
 * COPYRIGHT (C) 2019, FONTEVA, INC.
 * ALL RIGHTS RESERVED.
 *
 * ALL INFORMATION CONTAINED HEREIN IS, AND REMAINS THE PROPERTY OF FONTEVA
 * INCORPORATED AND ITS SUPPLIERS, IF ANY. THE INTELLECTUAL AND TECHNICAL
 * CONCEPTS CONTAINED HEREIN ARE PROPRIETARY TO FONTEVA INCORPORATED AND
 * ITS SUPPLIERS AND MAY BE COVERED BY U.S. AND FOREIGN PATENTS, PATENTS IN
 * PROCESS, AND ARE PROTECTED BY TRADE SECRET OR COPYRIGHT LAW. DISSEMINATION
 * OF THIS INFORMATION OR REPRODUCTION OF THIS MATERIAL IS STRICTLY FORBIDDEN
 * UNLESS PRIOR WRITTEN PERMISSION IS OBTAINED FROM FONTEVA, INC.
 * -----------------------------------------------------------------------------
 */

/* 
 * Project: FDService-Examples
 * Class: SearchRequestExamples
 */
public inherited sharing class SearchRequestExamples {


    public static List<FDService.Item> getAllItems() {
        //By just sending in an instance of search request this will get all records of that particular item.
        return FDService.ItemService.getInstance().get(
                FDService.SearchRequest.getInstance()
        );
    }

    public static List<FDService.Item> getSingleItemById(Id itemId) {
        //Select a single item, this method is also overloaded to take in a Set<Id> parameter as well
        return FDService.ItemService.getInstance().get(
                FDService.SearchRequest.getInstance().selectById(itemId)
        );
    }
}
