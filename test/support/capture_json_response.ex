defmodule PCAPredict.Support.CaptureJsonResponse do

  def find_response_with_postcode_objects do
    """
    {
    "Items": [
    {
    "Id": "GB|RM|ENG|6NJ-WR2",
    "Type": "Postcode",
    "Text": "WR2 6NJ",
    "Highlight": "0-3,4-7",
    "Description": "Moseley Road, Worcester - 47 Addresses"
    },
    {
    "Id": "GB|RM|ENG|6JN-WR2",
    "Type": "Postcode",
    "Text": "WR2 6JN",
    "Highlight": "0-3,4-5,6-7",
    "Description": "Nuffield Close, Worcester - 21 Addresses"
    }
    ]
    }
      """
  end

  def find_response_with_address_objects do
    """
    {"Items":[{"Id":"GB|RM|A|26742664","Type":"Address",
    "Text":"1 The Cottages, Moseley Road","Highlight":"",
    "Description":"Hallow, Worcester, WR2 6NJ"},
    {"Id":"GB|RM|A|26742665","Type":"Address","Text":"1 Wylcotts, Moseley Road",
    "Highlight":"","Description":"Hallow, Worcester, WR2 6NJ"},
    {"Id":"GB|RM|A|26742666","Type":"Address",
    "Text":"2 The Cottages, Moseley Road","Highlight":"",
    "Description":"Hallow, Worcester, WR2 6NJ"},
    {"Id":"GB|RM|A|52269655","Type":"Address",
      "Text":"2 Wylcotts, Moseley Road","Highlight":"",
      "Description":"Hallow, Worcester, WR2 6NJ"},
    {"Id":"GB|RM|A|26742627","Type":"Address",
      "Text":"Beaumont, Moseley Road","Highlight":"",
      "Description":"Hallow, Worcester, WR2 6NJ"}]}
    """
  end

  def invalid_key_response do
    """
    {
    "Items": [
    {
    "Error": "2",
    "Description": "Unknown key",
    "Cause": "The key you are using to access the service was not found.",
    "Resolution": "Please check that the key is correct. It should be in the form AA11-AA11-AA11-AA11."
      }
    ]
    }
    """
  end

  def invalid_text_response do
    """
    {"Items":
      [{"Error":"1001",
         "Description":"Text or Container Required",
         "Cause":"The Text or Container parameters were not supplied.",
         "Resolution":"Check they were supplied and try again."}]}
    """
  end

end
