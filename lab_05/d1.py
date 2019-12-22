from lxml import etree

def validate(xml_path: str, xsd_path: str) -> bool:

    xmlschema_doc = etree.parse(xsd_path);
    xmlschema = etree.XMLSchema(xmlschema_doc);

    xml_doc = etree.parse(xml_path);
    result = xmlschema.validate(xml_doc);

    return result;

if __name__ == "__main__":
    if validate("b1.xml", "c1.xsd"):
        print('Valid! :)');
    else:
        print('Not valid! :(');