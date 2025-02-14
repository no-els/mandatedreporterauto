from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.options import Options
import re
import time
import csv

# Function to extract principals and assistant principals from a given HTML content
def extract_principals(html_content):
    # Use regex to find elements containing "Principal"
    principal_pattern = re.compile(r'<li class="field-item">.*?<h3 class="field-item_name">Principal</h3>.*?<div class="field-item_value"><ul><li>(.*?)</li></ul></div>', re.DOTALL)
    principal_matches = principal_pattern.findall(html_content)

    # Use regex to find elements containing "Assistant Principal"
    assistant_principal_pattern = re.compile(r'<li class="field-item">.*?<h3 class="field-item_name">Assistant Principal\(s\)?</h3>.*?<div class="field-item_value"><ul><li>(.*?)</li></ul></div>', re.DOTALL)
    assistant_principal_matches = assistant_principal_pattern.findall(html_content)

    # Extract and categorize the names
    principals = [match.strip() for match in principal_matches]
    assistant_principals = [match.strip() for match in assistant_principal_matches]

    return principals, assistant_principals

# Set up Chrome options
chrome_options = Options()
chrome_prefs = {
    "download.default_directory": "/Users/noelngui/Code/mission_graduates_eleyo_lib/contact_files",  # Set download path
    "download.prompt_for_download": False,
    "profile.default_content_settings.popups": 0,
    "safebrowsing.enabled": True
}
chrome_options.add_experimental_option("prefs", chrome_prefs)

# Initialize the WebDriver
driver = webdriver.Chrome(options=chrome_options)

# Read the URLs from websites.txt
with open('websites.txt', 'r') as file:
    urls = file.readlines()

# Open the CSV file for writing
with open('principals.csv', 'w', newline='') as csvfile:
    fieldnames = ['URL', 'Principals', 'Assistant Principals']
    writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
    writer.writeheader()

    # Process each URL
    for url in urls:
        url = url.strip()
        if url:
            print(f"Processing {url}...")
            
            # Open the URL
            driver.get(url)

            # Allow the page to load
            time.sleep(2)

            # Extract the HTML content of the page
            html_content = driver.page_source

            # Extract principals and assistant principals
            principals, assistant_principals = extract_principals(html_content)

            # Write the extracted data to the CSV file
            writer.writerow({
                'URL': url,
                'Principals': ', '.join(principals),
                'Assistant Principals': ', '.join(assistant_principals)
            })

            # Flush the buffer to ensure data is written to the file
            csvfile.flush()

# Close the WebDriver
driver.quit()

print("Data has been written to principals.csv")