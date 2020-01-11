# -*- coding: utf-8 -*-
from lxml import etree

def parseXML(xmlFile):
    """
    Парсинг XML
    """
    with open(xmlFile) as fobj:
        xml = fobj.read();
    
    root = etree.fromstring(xml);
    
    for appt in root.getchildren():
        for elem in appt.getchildren():
            if not elem.text:
                text = "None"
            else:
                text = elem.text
            
            print(elem.tag + " => " + text);
        print("\n");
    return root;

def updateXML(root):
    new_element = etree.SubElement(root, "musicians");
    etree.SubElement(new_element, "musicians_id").text = "34";
    etree.SubElement(new_element, "name").text = "SuperSayan";
    etree.SubElement(new_element, "people_count").text = "12";
    etree.SubElement(new_element, "birthday").text = "1992";
    etree.SubElement(new_element, "is_dead").text = "1";
    etree.SubElement(new_element, "country").text = "Japan";
    return root;

def saveXML(root):
    f = open('b1-output.xml', 'wb');
    f.write(etree.tostring(root, pretty_print=True, xml_declaration=True));
    f.close();

if __name__ == "__main__":
    root = parseXML("b1-input.xml");
    root = updateXML(root);
    saveXML(root);
