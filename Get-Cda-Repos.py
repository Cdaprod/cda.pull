import asyncio
import os
from git import Repo

username = 'Cdaprod'

repo_names = [
    'cda.langchain-templates', 'cda.agents',
    'cda.Juno', 'cda.actions',
    'cda.data-lake', 'cda.ml-pipeline', 'cda.notebooks',
    'cda.CMS_Automation_Pipeline', 'cda.ml-pipeline',
    'cda.data', 'cda.databases', 'cda.s3',
    'cda.docker', 'cda.kubernetes', 'cda.jenkins',
    'cda.weaviate', 'cda.WeaviateApiFrontend',
    'cda.Index-Videos',
    'cda.dotfiles', 'cda.faas', 'cda.pull', 'cda.resumes', 'cda.snippets', 'cda.superagent', 'cda.ZoomVirtualOverlay', 'cda.knowledge-platform',
    'cda.nginx'
]

base_path = '/home/cda/cda.REPOS'

# Path to the cache file
cache_file = os.path.join(base_path, 'clone_cache.txt')

def read_cache():
    if os.path.exists(cache_file):
        with open(cache_file, 'r') as file:
            return set(file.read().splitlines())
    return set()

def write_cache(repo_name):
    with open(cache_file, 'a') as file:
        file.write(repo_name + '\n')

async def clone_repo(repo_name, base_path, pat, cached_repos):
    if repo_name in cached_repos:
        print(f'Skipping {repo_name}, already cloned.')
        return
    
    repo_url = f'https://x-access-token:{pat}@github.com/{username}/{repo_name}.git'
    dest_path = os.path.join(base_path, repo_name)
    if not os.path.exists(dest_path):
        try:
            print(f'Cloning {repo_name} into {dest_path}')
            await loop.run_in_executor(None, Repo.clone_from, repo_url, dest_path)
            write_cache(repo_name)
        except Exception as e:
            print(f'Failed to clone {repo_name}: {e}')
    else:
        print(f'Repository {repo_name} already exists at {dest_path}')
        write_cache(repo_name)

async def main(username, repo_names, base_path):
    pat = os.getenv('GH_TOKEN')
    if not pat:
        raise EnvironmentError('The environment variable GITHUB_PAT is not set.')
    
    cached_repos = read_cache()
    clone_tasks = [clone_repo(repo_name, base_path, pat, cached_repos) for repo_name in repo_names]
    await asyncio.gather(*clone_tasks)

if __name__ == '__main__':
    loop = asyncio.get_event_loop()
    loop.run_until_complete(main(username, repo_names, base_path))
