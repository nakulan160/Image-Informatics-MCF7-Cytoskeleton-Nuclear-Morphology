#!/usr/bin/env python3
"""Extract the verified BBBC021 experiment's TIFF images from official plate ZIP files.
Usage:
 python extract_BBBC021_selected.py --archive-dir ~/Downloads --out-dir ./BBBC021_selected
Add --pilot to extract only the 9 TIFF images listed in BBBC021_pilot_images.csv.
Place this script and BOTH supplied manifest CSVs in the same folder.
"""
import argparse,csv,pathlib,zipfile,shutil,sys
parser=argparse.ArgumentParser(description=__doc__)
parser.add_argument('--archive-dir',type=pathlib.Path,default=pathlib.Path.home()/'Downloads')
parser.add_argument('--out-dir',type=pathlib.Path,default=pathlib.Path('BBBC021_selected'))
parser.add_argument('--pilot',action='store_true')
args=parser.parse_args()
base=pathlib.Path(__file__).resolve().parent
manifest=base/('BBBC021_pilot_images.csv' if args.pilot else 'BBBC021_selected_images.csv')
if not manifest.is_file():sys.exit('Missing manifest: '+str(manifest))
with manifest.open(newline='') as f: records=list(csv.DictReader(f))
by_archive={}
for r in records:
    for channel in ['DAPI','Actin','Tubulin']:
        by_archive.setdefault(r['ZIP_archive'],[]).append((r,channel,r[channel]))
extracted=0
for archive,items in by_archive.items():
    zip_path=args.archive_dir/archive
    if not zip_path.is_file():
        print('MISSING ARCHIVE:',zip_path,'(skipping)')
        continue
    print('Reading:',zip_path)
    with zipfile.ZipFile(zip_path) as z:
        idx={pathlib.PurePosixPath(n).name:n for n in z.namelist() if not n.endswith('/')}
        for r,channel,name in items:
            member=idx.get(name)
            if member is None:
                print('NOT FOUND:',name,'in',archive)
                continue
            dest=args.out_dir/r['plate']/r['well']/f"site_{r['field']}"/(channel+'_'+name)
            dest.parent.mkdir(parents=True,exist_ok=True)
            with z.open(member) as src, dest.open('wb') as dst:shutil.copyfileobj(src,dst)
            extracted+=1
print('Done. Extracted',extracted,'TIFF images to',args.out_dir)
print('Pilot: expect 9 files; full manifest: expect 144 files. Missing plate ZIPs are skipped.')
