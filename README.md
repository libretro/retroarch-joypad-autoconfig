# Joypad Autoconfig Files

This repository stores joypad autoconfig files for Retroarch. RetroArch is the reference frontend for the libretro API. 

Autoconfig files included in this repository are used to recognize input devices and automatically setup default mappings between the physical device and Retropad virtual controller.

## How to create an autoconfig file

If your input device is not recognized by RetroArch even after updating the profiles, you can generate a profile from the menu.

You can find detailed instructions [here](https://www.retroarch.com/index.php?page=joypad-autoconfig)

## Uploading your own autoconfig file

If you want to share an autoconfig file that is missing in Retroarch you can upload it to this repository. 
Please remember that the goal of sharing your autoconfig file is to create a bigger database of default controller mappings that can be used by other people. 
If your mapping is custom-made for your own needs, it won't be really useful for others. It's better if you share more generic and reusable mappings that can act as a "default"

### To upload your autoconfig file follow these steps

#### 1. Checking for duplicates

Retroarch uses three attributes of the controller to identify which autoconfig file to use: vendor ID, product ID and device name.
Before uploading your file, please verify that there isn't another autoconfig file matching those three attributes. 

You can verify this by comparing the values for `input_vendor_id`, `input_product_id` and `input_device` attributes. 
If another autoconfig file exists including the same vendor ID, product ID and input device name your autoconfig file will cause conflicts.

#### 2. Adding input descriptors

Input descriptors are the labels that Retroarch will display in the UI to describe buttons and axes of your device. 
It's recommended to add descriptors so Retroarch can display useful labels in the UI. 

Input descriptor attributes are not added by default, you need to manually add the attributes inside the autonconfig file that was generated but Retroarch. 

e.g:

```
input_b_btn_label = "Cross"
input_y_btn_label = "Square"
input_a_btn_label = "Circle"
input_x_btn_label = "Triangle"
```

You will find more details about the attribute name syntax below (Input descriptors section)

#### 3. Testing your autoconfig file

Before uploading your autoconfig file please verify that Retroarch is correctly detecting the file and also displaying all the labels for the controller. 
You can verify it in `Settings->Inputs->User 1 Binds`

The best way to confirm everything is working is:

1. Reset your binds to the defaults using `Settings->Inputs->User 1 Binds>User 1 Bind Default All` option
2. Un-plug and Re-Plug your controller
3. Check the mappings in `Settings->Inputs->User 1 Binds` to confirm they are correct

#### 4. Creating a Pull Request

To upload your autoconfig file to this repository you must create a [Pull Request](https://en.wikipedia.org/wiki/Distributed_version_control#Pull_requests).

You can learn how to create a Pull Request in Github reading these [instructions](https://help.github.com/en/articles/creating-new-files)

**Note:** Verify you are creating the file in the correct folder. It must have the same name than the `input_driver` attribute

## File format

Autoconfig files are formed by a list of attributes and their corresponding values using the following syntax: `attribute_name = value`.

Attribute names use [snake_case](https://en.wikipedia.org/wiki/Snake_case) naming scheme.

### There are three types of attributes:

#### 1. Device descriptors

These are attributes that identify the phyisical device

Attribute | Description
------------ | -------------
input_driver | Driver in-use when the controller was detected
input_device | Name reported by the device
input_vendor_id | Vendor ID reported by the device
input_product_id | Product ID reported by the device
input_device_display_name | Display name to show in Retroarch's UI when referencing the controller (Optional)

#### 2. Button/axes Mappings

These are attributes that describe the mapping between physical buttons/axes and Retropad virtual controller. 

Attributes are named following the pattern `input` + `button/axis name` + `input type`. 
Input type can be either `axis` or `btn` (button)

![Retropad Layout](/retropad_layout.png?raw=true)

Attribute | Description
------------ | -------------
input_b_btn | Device button mapped to Retropad's B button
input_y_btn | Device button mapped to Retropad's Y button
input_select_btn | Device button mapped to Retropad's Select button
input_start_btn | Device button mapped to Retropad's Start button
input_up_btn | Device button mapped to Retropad's D-Pad Up button
input_down_btn | Device button mapped to Retropad's D-Pad Down button
input_left_btn | Device button mapped to Retropad's D-Pad Left button
input_right_btn | Device button mapped to Retropad's D-Pad Right button
input_a_btn | Device button mapped to Retropad's A button
input_x_btn | Device button mapped to Retropad's X button
input_l_btn | Device button mapped to Retropad's Left shoulder
input_r_btn | Device button mapped to Retropad's Right shoulder
input_l2_btn | Device button mapped to Retropad's Left trigger
input_r2_btn | Device button mapped to Retropad's Right trigger
input_l3_btn | Device button mapped to Retropad's Left Thumb Button
input_r3_btn | Device button mapped to Retropad's Right Thumb Button
input_l_x_plus_axis | Device axis mapped to Retropad's Left Analog (Right)
input_l_x_minus_axis | Device axis mapped to Retropad's Left Analog (Left)
input_l_y_plus_axis | Device axis mapped to Retropad's Left Analog (Down)
input_l_y_minus_axis | Device axis mapped to Retropad's Left Analog (Up)
input_r_x_plus_axis | Device axis mapped to Retropad's Right Analog (Right)
input_r_x_minus_axis | Device axis mapped to Retropad's Right Analog (Left)
input_r_y_plus_axis | Device axis mapped to Retropad's Right Analog (Down)
input_r_y_minus_axis | Device axis mapped to Retropad's Right Analog (Up)
input_menu_toggle_btn | Device button mapped to Retropad's Menu button

#### 3. Input descriptors

Input descriptors are the labels that Retroarch will display in the UI to describe buttons and axes of your device. They should match your physical controller's labels

The format for input descriptors' attribute names is: `input name` + `label`

e.g:

```
input_l2_btn = "5"  <-- Input mapping
input_l2_btn_label = "L2" <-- Input descriptor
```

**Note:** It's important that `input name` matches exactly the input name defined in the autoconfig file. If the input you are describing is an axis, the input descriptor must be for an axis.

e.g:

```
input_l2_axis = "+3"  <-- Input mapping

input_l2_btn_label = "L2" <-- WRONG
input_l2_axis_label = "L2" <-- RIGHT
```
