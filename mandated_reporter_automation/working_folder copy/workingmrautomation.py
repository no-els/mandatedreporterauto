# %%
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver import ActionChains
import time
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.chrome.options import Options

chrome_options = Options()
chrome_prefs = {

    "download.prompt_for_download": False,
    "profile.default_content_settings.popups": 0,
    "safebrowsing.enabled": True
}
chrome_options.add_experimental_option("prefs", chrome_prefs)
# For this example, I'll assume you're using Chrome
driver = webdriver.Chrome(options=chrome_options)
# Open the URL
driver.get('https://account.mandatedreportertraining.com/')
# Allow the page to load
time.sleep(2)
# Find the email input field by XPath and input the username
username_field = driver.find_element(By.XPATH, '//*[@id="mat-input-0"]')
username_field.send_keys('nngui@missiongraduates.org')
password_field =  driver.find_element(By.XPATH, '//*[@id="mat-input-1"]')
password_field.send_keys('Badabingbadaboom!00')

submit_button = driver.find_element(By.XPATH, '/html/body/app-root/app-blank/div[2]/div/mat-sidenav-container/mat-sidenav-content/app-login/div/div/div/div/div[1]/div/div/div/form/div[3]/button')
submit_button.click()
wait = WebDriverWait(driver, 20)

# %%
reports = wait.until(EC.visibility_of_element_located((By.XPATH,'//*[@id="snav"]/div/app-sidebar/mat-nav-list/mat-list-item[5]/span/a/span[1]')))
reports.click()

# %%
reports = wait.until(EC.visibility_of_element_located((By.XPATH,'//*[@id="snav"]/div/app-sidebar/mat-nav-list/mat-list-item[5]/span/mat-nav-list/mat-list-item[1]/span/a')))
reports.click()

# %%
reports = wait.until(EC.visibility_of_element_located((By.XPATH,'//*[@id="mat-select-2"]/div/div[2]')))
reports.click()

# %%
reports = wait.until(EC.visibility_of_element_located((By.XPATH,'//*[@id="mat-option-3"]/span')))
reports.click()

# %%
reports = wait.until(EC.visibility_of_element_located((By.XPATH,'//*[@id="scrolldiv"]/div/div[2]/app-batch-assign-training/div/form/div[2]/a/mat-icon')))
reports.click()

# %%
import openpyxl
file_path = "input/input.xlsx"  # Replace with your file path
workbook = openpyxl.load_workbook(file_path)
sheet = workbook.active  # Selects the first (active) sheet

# Extract values from column A (excluding header)
emails = [cell.value for cell in sheet['A'][1:] if cell.value is not None]

# %%
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.common.by import By
from selenium.common.exceptions import TimeoutException

short_wait = WebDriverWait(driver, 2)  # Timeout set to 2 seconds

for email in emails:
    # Clear and re-locate the search field
    search_field = driver.find_element(By.XPATH, '//*[@id="mat-input-3"]')
    search_field.clear()
    search_field.send_keys(email)
    time.sleep(1)  # Short delay for input processing

    try:
        # Wait up to 2 seconds for the reports element to appear
        reports = short_wait.until(EC.visibility_of_element_located(
            (By.XPATH, '//*[@id="mat-mdc-dialog-0"]/div/div/app-select-learner-emails/app-modal-layout/div/div[2]/div[1]/div/div[1]/div/div/button')
        ))
        reports.click()
    except TimeoutException:
        # If the element does not appear in 2 seconds, skip to the next email
        print(f"No reports found for: {email}")
        with open("peoplenotfound.txt", "a") as file:
            file.write(f"No reports found for: {email}\n")
        continue
    
    # Clear search field for the next email
    search_field = driver.find_element(By.XPATH, '//*[@id="mat-input-3"]')
    search_field.clear()

# %%


# %%



