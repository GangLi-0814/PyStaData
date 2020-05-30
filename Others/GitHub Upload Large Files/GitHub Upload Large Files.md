> Source: https://git-lfs.github.com/

## Step 01

[Download](https://github.com/git-lfs/git-lfs/releases/download/v2.11.0/git-lfs-windows-v2.11.0.exe "Download") and install the Git command line extension. Once downloaded and installed, set up Git LFS for your user account by running:

```git
git lfs install
```

## Step 02

**You only need to run this once per user account**.

In each Git repository where you want to use Git LFS, select the file types you'd like Git LFS to manage (or directly edit your `.gitattributes`). You can configure additional file extensions at anytime.

```
git lfs track "*.psd"
```

Now make sure `.gitattributes` is tracked:

```
git add .gitattributes
```

Note that defining the file types Git LFS should track will not, by itself, convert any pre-existing files to Git LFS, such as files on other branches or in your prior commit history. To do that, use the [git lfs migrate](https://github.com/git-lfs/git-lfs/blob/master/docs/man/git-lfs-migrate.1.ronn?utm_source=gitlfs_site&utm_medium=doc_man_migrate_link&utm_campaign=gitlfs "git lfs migrate") command, which has a range of options designed to suit various potential use cases.

## Step 03

There is no step three. Just commit and push to GitHub as you normally would.

```
git add file.psd
git commit -m "Add design file"
git push origin master
```