# How to modify `build/appinfo.json` file

[appinfo.json](../build/appinfo.json) is a file used to keep some documents up to date, it contains a list of all documents, YouTube videos and script tools.

Keeping this file up to date help to maintain all other important document files.

**When modifying this file, make sure it is still a valid `json` file.**

## Files that relies on `appinfo.json`

- [docs/README.md](README.md)
- [docs/AppList.md](AppList.md)
- [tools/README.md](../tools/README.md)

## File Structure

This file uses `json` language and it contains 4 main sections:

- **[apps](#apps-section)**
- **[youtube](#youtube-section)**
- **[docs](#docs-section)**
- **[tools](#tools-section)**

## APPS section

This section is used to link **Documents**, **Tools** and **Videos** to each app in the Template list. If an app doesn't have any of those items, it doesn't need to be listed in the file.

It can have the following elements:

- `Title`: App Title, exactly as written in Template JSON file **(mandatory)**
- `DocID`: Document **ID** as listed on [docs section](#docs-section) **(optional)**
- `ScriptID`: Script **ID** as listed on [tools section](#tools-section). This is usually a script to preintall an app **(optional)** 
- `ExtraID`: Script **ID** as listed on [tools section](#tools-section). This can be any extra script used to maintain an app. This item can be listed as a single value or as an array (e.g. [3, 5]) **(optional)** 
- `VideoID`: Video **ID** as listed on [youtube section](#docs-section) **(optional)**

Example 1:
```json
{
    "Title": "App In Template",
    "DocID": 2,
    "ScriptID": 7,
    "VideoID": 9
}
```

Example 2:
```json
{
    "Title": "Example App",
    "DocID": 2,
    "ScriptID": 7,
	"ExtraID": [3, 10],
    "VideoID": 9
}
```

## YOUTUBE section

Here all YouTube videos are listed. It contains the following elements:

- `ID`: Episode Number or a sequential **ExtraNN** number when it's a related episode but does not contain any number **(mandatory)**
- `Title`: Episode Title as listed on YouTube **(mandatory)**
- `URL`: Episode URL, preferable using the link from the playlist **(mandatory)**
- `DocID`: If a Episode is link to a helper document, list the **ID** here **(optional)**

Example:
```json
{
    "ID": 7,
    "Title": "Raspberry Pi Docker Monitoring",
    "URL": "https://www.youtube.com/watch?v=IoD3vFuep64&list=PL846hFPMqg3jwkxcScD1xw2bKX
index=8",
    "DocID": 3
}
```

## DOCS section

This section will list all generated doc files with a description. **All items are mandatory**:

- `ID`: Sequential ID number to be used as a link within this document
- `File`: Contains the exact file name (case sensitive) as used within `docs/` folder
- `Description`: Will be used as a title on the README page

Example:
```json
{
    "ID": 3,
    "File": "rpi_docker_monitor.md",
    "Description": "Install and setup instructions for the RPI Docker Monitor"
}
```

## TOOLS section

This section will list all script files included within `tools` folder.

List of items:

- `ID`: Sequential ID number to be used as a link within this document **(mandatory)**
- `File`: Contains the exact file name (case sensitive) as used within `tools/` folder **(mandatory)**
- `Type`: Type of script (`Install`, `Preinstall`, `Update` or `Extra`). If not listed will default to `Preinstall` **(optional)**
- `Exec`: tool used to run the file (normally `bash` or `sudo bash`). If not listed will default to `bash` **(optional)**
- `Description`: Text describing the use of the script **(mandatory)**
- `DocID`: Document **ID** when file is referenced on a document **(optional)**
- `wget`: Shortened URL use to download the script

Example:
```json
{
    "ID": 9,
    "File": "rpi_docker_monitor.sh",
    "Type": "Preinstall",
    "Exec": "bash",
    "Description": "Preinstall Setup for Docker Monitor",
    "DocID": 3,
    "wget": "https://git.io/JPXba"
}
```
