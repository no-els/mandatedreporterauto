import streamlit as st
from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.common.by import By
import base64
import time
import os

st.title("Selenium Automation with Streamlit")

# Input for the user to enter the URL
url = st.text_input("Enter the URL to visit:", "https://example.com")

# Button to trigger Selenium automation
if st.button("Run Selenium Automation"):
    st.info("Launching browser and capturing a screenshot...")

    # Manually set Chrome binary and ChromeDriver paths
    CHROME_BINARY_PATH = "/usr/bin/google-chrome"  # Default for Ubuntu/Streamlit Cloud
    CHROMEDRIVER_PATH = "/usr/bin/chromedriver"  # Default ChromeDriver path

    # Set up Selenium ChromeOptions
    options = webdriver.ChromeOptions()
    options.add_argument("--headless")  # Run in headless mode
    options.add_argument("--no-sandbox")
    options.add_argument("--disable-dev-shm-usage")
    options.binary_location = CHROME_BINARY_PATH  # Use system-installed Chromium

    # Initialize WebDriver using pre-installed ChromeDriver
    driver = webdriver.Chrome(service=Service(CHROMEDRIVER_PATH), options=options)

    try:
        # Visit the URL
        driver.get(url)
        time.sleep(2)  # Allow time for page load

        # Take a screenshot
        screenshot_path = "screenshot.png"
        driver.save_screenshot(screenshot_path)

        # Display the screenshot in Streamlit
        with open(screenshot_path, "rb") as file:
            img_data = file.read()
            img_base64 = base64.b64encode(img_data).decode()
        st.image(f"data:image/png;base64,{img_base64}", caption="Captured Screenshot", use_column_width=True)

        # Display feedback
        st.success(f"Page Title: {driver.title}")

    except Exception as e:
        st.error(f"An error occurred: {e}")

    finally:
        driver.quit()
