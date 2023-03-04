# Flutter Shop App

### Welcome to my e-Shop project!

This is a personal project through which I am learning flutter. 
It's an eCommerce application that is currently working with [Firebase](https://firebase.google.com/) as it's backend. 
Here you will see many patterns in action and how they are implemented. 

Some of them are:
- page navigation 
- state managment with `Provider`
- networking with `http`

<br>

## Getting Started

To get a local copy up and running follow the steps below: 

### Prerequisites

Before running the application, make sure you have the following installed on your system: 

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- [VS Code](https://code.visualstudio.com/) installed along with the [Flutter extension](https://flutter.dev/docs/get-started/editor?tab=vscode) *(this is a recommendation, so you can use the GUI)*

<br>

### Running the App

1. Clone the repo to your local machine with the following command:

   ```sh
   git clone https://github.com/Faris-Hadziomerovic/flutter-shop-app.git
   ```

<br>

2. Open the project folder in VS Code *(recommended)* 

<br>

3. Install packages by running the command:

   ```sh
   flutter pub get
   ```

<br>

4. To select a device you can:
    - open the command pallete with `Ctrl+Shift+P` and enter `Flutter: Select Device`
    - or open the device selection menu from the bottom tool bar

<br>

5. To run the app you can:
    - press F5 or click on the `Run` button in the top toolbar *(recommended for all but web)*
    - run one of the following commands:
    
        ```sh    
        # standard:
        > flutter run
        
        # for web (chrome):
        > flutter run -d chrome --web-renderer html
        ```

<br>

6. The app should launch in the emulator, web or on your physical device if it's connected


<br>

## Preview

<br>

This is the first and main screen showing an overview of products and some actions that can be performed like pull to refresh, favourite and add to cart.
On the second image we can see the globally-available side-menu used for navigating through the following screens.

![products-overview-with-refresh-and-alert](https://user-images.githubusercontent.com/64084436/221404994-f8a2214d-011c-4d10-b2b0-a77e7a600045.png)
![side-menu](https://user-images.githubusercontent.com/64084436/221404997-4c8694fb-c564-49e9-9bed-8aedd935fcca.png)



This is the same screen just in landscape mode.

![products-overview-landscape](https://user-images.githubusercontent.com/64084436/221405009-8442406a-b1ea-4752-b50a-a621d8101ab0.png)



Here are the user's own products, options to add new and edit / delete existing ones. 
On the second screen you can see the edit product screen with some field validations and image previews.

![user-products](https://user-images.githubusercontent.com/64084436/221404999-adb5d4d5-a131-484d-baca-0f94cfe34067.png)
![edit-product-with-errors](https://user-images.githubusercontent.com/64084436/221405006-fc0371f1-2d65-4830-b0b1-b3605fea42e6.png)



This is the My Cart screen shown when it's empty.

![cart-empty-landscape](https://user-images.githubusercontent.com/64084436/221405001-83d72890-6c11-463c-a137-ae8f0da2c833.png)



This shows an overview of the actions necessary to remove an item from the cart.

![cart-slide-to-remove](https://user-images.githubusercontent.com/64084436/221405004-27702301-541f-47b1-9f60-74997580022c.png)
![cart-remove-dialog](https://user-images.githubusercontent.com/64084436/221405003-9fbcec34-e46c-4e6e-80bc-b0aafc6ff137.png)



At the end of the flow we have the already ordered items and just their preview. 
We can't do anything about them, they are already paid for, we can just expand and minimize.

![orders-partial](https://user-images.githubusercontent.com/64084436/221405008-439353cb-f204-42f6-9c5d-32e0b3d454a2.png)
