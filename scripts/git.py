import logging
import subprocess


class Git:
    def __init__(self):
        super().__init__()
        self.logger = logging.getLogger(__name__)

    def add(self, files):
        if len(files) == 0:
            self.logger.error("Files cannot be empty.")
            raise Exception("Files cannot be empty.")

        args = ["add"]

        if isinstance(files, str):
            args.append(files)
        elif isinstance(files, (tuple, list)):
            args.extend(files)
        else:
            self.logger.error("Argument files must be str, list or tuple")
            raise Exception("Argument files must be str, list or tuple")

        self.logger.info(" ".join(args))
        self._run(args)
        self.logger.info("Add done.")

    def commit(self, message: str):
        if len(message) == 0:
            self.logger.error("Message cannot be empty.")
            raise Exception("Message cannot be empty.")

        self.logger.info(f"git commit -m {message}")
        self._run(["commit", "-m", message])
        self.logger.info("Commit done.")

    def push(self, branch: str):
        if len(branch) == 0:
            self.logger.error("Branch name cannot be empty.")
            raise Exception("Branch name cannot be empty.")

        self.logger.info(f"git push origin {branch}")
        self._run(["push", "origin", branch])
        self.logger.info("Push done.")

    def _run(self, args: list):
        cmd = ["git"]
        cmd.extend(args)
        process = subprocess.run(cmd)
        returncode = process.returncode
        if returncode != 0:
            self.logger.error(f"Non zero execution result. {returncode}")
            raise Exception(f"Non zero execution result. {returncode}")
