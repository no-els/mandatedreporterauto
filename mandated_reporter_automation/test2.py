import tkinter as tk
from tkinter import filedialog, messagebox
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.common.exceptions import TimeoutException
from selenium.webdriver.chrome.options import Options
import openpyxl
import time
import os

# Function to automate Selenium task
def run_script():
    username = username_entry.get()
    password = password_entry.get()
    file_path = file_path_var.get()

    if not username or not password or not file_path:
        messagebox.showerror("Error", "Please fill all fields and select an Excel file.")
        return

    # Set up Chrome options
    chrome_options = Options()
    chrome_prefs = {
        "download.prompt_for_download": False,
        "profile.default_content_settings.popups": 0,
        "safebrowsing.enabled": True
    }
    chrome_options.add_experimental_option("prefs", chrome_prefs)

    # Start Selenium
    driver = webdriver.Chrome(options=chrome_options)
    wait = WebDriverWait(driver, 20)

    try:
        # Open the URL
        driver.get('https://account.mandatedreportertraining.com/')
        time.sleep(2)

        # Login
        driver.find_element(By.XPATH, '//*[@id="mat-input-0"]').send_keys(username)
        driver.find_element(By.XPATH, '//*[@id="mat-input-1"]').send_keys(password)
        driver.find_element(By.XPATH, '/html/body/app-root/app-blank/div[2]/div/mat-sidenav-container/mat-sidenav-content/app-login/div/div/div/div/div[1]/div/div/div/form/div[3]/button').click()

        # Navigate to Reports
        reports = wait.until(EC.visibility_of_element_located((By.XPATH, '//*[@id="snav"]/div/app-sidebar/mat-nav-list/mat-list-item[5]/span/a/span[1]')))
        reports.click()

        reports = wait.until(EC.visibility_of_element_located((By.XPATH, '//*[@id="snav"]/div/app-sidebar/mat-nav-list/mat-list-item[5]/span/mat-nav-list/mat-list-item[1]/span/a')))
        reports.click()

        wait.until(EC.visibility_of_element_located((By.XPATH, '//*[@id="mat-select-2"]/div/div[2]'))).click()
        wait.until(EC.visibility_of_element_located((By.XPATH, '//*[@id="mat-option-3"]/span'))).click()
        wait.until(EC.visibility_of_element_located((By.XPATH, '//*[@id="scrolldiv"]/div/div[2]/app-batch-assign-training/div/form/div[2]/a/mat-icon'))).click()

        # Process Excel File
        workbook = openpyxl.load_workbook(file_path)
        sheet = workbook.active
        emails = [cell.value for cell in sheet['A'][1:] if cell.value is not None]

        short_wait = WebDriverWait(driver, 2)
        for email in emails:
            search_field = driver.find_element(By.XPATH, '//*[@id="mat-input-3"]')
            search_field.clear()
            search_field.send_keys(email)
            time.sleep(1)

            try:
                reports = short_wait.until(EC.visibility_of_element_located(
                    (By.XPATH, '//*[@id="mat-mdc-dialog-0"]/div/div/app-select-learner-emails/app-modal-layout/div/div[2]/div[1]/div/div[1]/div/div/button')
                ))
                reports.click()
            except TimeoutException:
                with open("peoplenotfound.txt", "a") as file:
                    file.write(f"No reports found for: {email}\n")
            search_field.clear()

        messagebox.showinfo("Success", "Automation completed successfully!")
    except Exception as e:
        messagebox.showerror("Error", f"An error occurred: {str(e)}")

# Function to select Excel file
def select_file():
    file_path = filedialog.askopenfilename(filetypes=[("Excel files", "*.xlsx")])
    if file_path:
        file_path_var.set(file_path)

# Tkinter GUI Setup
root = tk.Tk()
root.title("Selenium Automation Tool")

# Username Input
tk.Label(root, text="Username:").pack()
username_entry = tk.Entry(root, width=40)
username_entry.pack()

# Password Input
tk.Label(root, text="Password:").pack()
password_entry = tk.Entry(root, width=40, show="*")
password_entry.pack()

# File Selection
tk.Label(root, text="Excel File:").pack()
file_path_var = tk.StringVar()
file_entry = tk.Entry(root, textvariable=file_path_var, width=30)
file_entry.pack(side="left")
tk.Button(root, text="Browse", command=select_file).pack(side="right")

# Run Button
tk.Button(root, text="Run Automation", command=run_script).pack(pady=10)

root.mainloop()
