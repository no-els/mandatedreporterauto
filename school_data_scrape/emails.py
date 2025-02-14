from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.options import Options
import time
import csv

# Function to extract email and name from a given HTML content
def extract_email_and_name(driver):
    try:
        # Check if the page contains the "Sorry, the page you are looking for cannot be found." message
        if "Sorry, the page you are looking for cannot be found." in driver.page_source:
            return None, None
        
        # Extract the name
        name_element = driver.find_element(By.CSS_SELECTOR, 'h1')
        name = name_element.text.strip()

        # Extract the email
        email_element = driver.find_element(By.XPATH, "//a[contains(@href, 'mailto:') and contains(text(), '@sfusd.edu')]")
        email = email_element.text.strip()

        return name, email
    except Exception as e:
        return None, None

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

# Read the URLs from people.txt
with open('people.txt', 'r') as file:
    urls = file.readlines()

# Open the CSV file for writing
with open('people_emails.csv', 'w', newline='') as csvfile:
    fieldnames = ['Name', 'Email']
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

            # Extract the email and name
            name, email = extract_email_and_name(driver)

            # Write the extracted data to the CSV file if email is found
            if email:
                writer.writerow({'Name': name, 'Email': email})

            # Flush the buffer to ensure data is written to the file
            csvfile.flush()

# Close the WebDriver
driver.quit()

print("Data has been written to people_emails.csv")