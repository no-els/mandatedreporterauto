import streamlit as st
from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.common.by import By
import base64
import time
import os
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.chrome.service import Service
from webdriver_manager.chrome import ChromeDriverManager
from webdriver_manager.core.os_manager import ChromeType

st.title("Selenium Automation with Streamlit")

def get_driver():
        return webdriver.Chrome(
            service=Service(
                ChromeDriverManager(chrome_type=ChromeType.CHROMIUM).install()
            ),
            options=options,
        )


# Input for the user to enter the URL
url = st.text_input("Enter the URL to visit:", "https://example.com")

# Button to trigger Selenium automation
if st.button("Run Selenium Automation"):
    st.info("Launching browser and capturing a screenshot...")


options = Options()
options.add_argument("--disable-gpu")
options.add_argument("--headless")

driver = get_driver()

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

