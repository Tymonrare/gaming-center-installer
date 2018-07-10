import urllib.request
import xml.etree.ElementTree as ET
import re
import time

def get_file_versions(urladress, filepath):

	folderlist = urllib.request.urlopen(urladress+"/?prefix="+filepath+"&delimiter=/&uncache="+str(time.time())).read()
	root = ET.fromstring(folderlist)

	ns = {'ns' : 'http://s3.amazonaws.com/doc/2006-03-01/'}

	versions = []

	for Contents in root.findall('ns:Contents', ns):
		text = Contents.find('ns:Key', ns).text
		m = re.search(filepath+'v(\d+)', text)
	
		if m is None:
			continue
	
		versions.append(int(m.group(1)))
	
	versions.sort(reverse=True)
	
	return versions
	
def get_file_last_version(urladress, filepath):
	return get_file_versions(urladress, filepath)[0]
