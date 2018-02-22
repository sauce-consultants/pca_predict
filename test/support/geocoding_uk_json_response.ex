defmodule PCAPredict.Support.GeocodingUKJsonResponse do

  def find_response_with_postcode_objects do
    """
    [
    {
    "Location": "Moseley Road, Hallow, Worcester",
    "Easting": "381676",
    "Northing": "259425",
    "Latitude": "52.2327",
    "Longitude": "-2.2697",
    "OsGrid": "SO 81676 59425",
    "Accuracy": "Standard"
    }
    ]
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
