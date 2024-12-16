import streamlit as st
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.service import Service
from webdriver_manager.chrome import ChromeDriverManager
import time



st.title("Selenium Automation with Streamlit")

# Input for the user to enter the URL
url = st.text_input("Enter the URL to visit", "https://example.com")

# Button to trigger Selenium automation
if st.button("Run Selenium Automation"):
    st.info("Launching browser and visiting the URL...")

    # Set up Selenium WebDriver
    options = webdriver.ChromeOptions()
    options.add_argument("--headless")  # Comment this line to see the browser
    options.add_argument("--no-sandbox")
    options.add_argument("--disable-dev-shm-usage")

    # Initialize WebDriver
    driver = webdriver.Chrome(service=Service(ChromeDriverManager().install()), options=options)

    try:
        # Visit the specified URL
        driver.get(url)
        time.sleep(2)  # Wait for the page to load

        # Example interaction: Get the page title
        title = driver.title
        st.success(f"Page title: {title}")

        # Example interaction: Search for an element by tag
        h1_element = driver.find_element(By.TAG_NAME, "h1")
        st.write(f"H1 Tag: {h1_element.text}")

    except Exception as e:
        st.error(f"An error occurred: {e}")
    finally:
        driver.quit()
