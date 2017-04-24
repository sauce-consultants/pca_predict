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
