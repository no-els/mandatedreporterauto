import streamlit as st
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.service import Service
from webdriver_manager.chrome import ChromeDriverManager
import time
import base64


st.title("Selenium Automation with Streamlit")

# Input for the user to enter the URL
url = st.text_input("Enter the URL to visit", "https://missiongraduates.reg.eleyo.com/admin/authentication/login")

# Button to trigger Selenium automation
if st.button("Run Selenium Automation"):
    st.info("Launching browser and visiting the URL...")

    # Set up Selenium WebDriver
    options = webdriver.ChromeOptions()
    #options.add_argument("--headless")  # Comment this line to see the browser
    options.add_argument("--no-sandbox")
    options.add_argument("--disable-dev-shm-usage")

    # Initialize WebDriver
    driver = webdriver.Chrome(service=Service(ChromeDriverManager().install()), options=options)

    try:
        # Visit the specified URL
        driver.get(url)
        time.sleep(2)  # Wait for the page to load

        screenshot_path = "screenshot.png"
        driver.save_screenshot(screenshot_path)

        # Read the screenshot and encode it for display
        with open(screenshot_path, "rb") as file:
            img_data = file.read()
            img_base64 = base64.b64encode(img_data).decode()

        # Display the screenshot in Streamlit
        st.image(f"data:image/png;base64,{img_base64}", caption="Captured Screenshot", use_column_width=True)

        # Display the page title as feedback
        st.success(f"Page Title: {driver.title}")

    except Exception as e:
        st.error(f"An error occurred: {e}")
    finally:
        driver.quit()
